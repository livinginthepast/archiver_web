class Uploader {
  constructor (prefix, file) {
    this.prefix = prefix;
    this.file = file;

    this.state = 'new'
  }

  key () {
    return this.prefix + '/' + this.file.name;
  }

  upload () {
    console.log('beginning upload');
    fetch(this._presignUrl(), {
      credentials: 'same-origin'
    })
      .then(this._parsePresigning.bind(this))
      .then(this._upload.bind(this));
  }

  _notifyFailure () {
    var event = new CustomEvent('s3.upload.failure', {
      bubbles: true,
      cancelable: true,
      detail: {
        success: false,
        uploader: this
      }
    });
    $$(document).dispatchEvent(event);
  }

  _notifySuccess () {
    var event = new CustomEvent('s3.upload.success', {
      bubbles: true,
      cancelable: true,
      detail: {
        success: true,
        uploader: this
      }
    });
    $$(document).dispatchEvent(event);
  }

  _presignUrl () {
    var basePath = this.constructor.basePath || '/integrations/s3/presign';
    return basePath + '?key=' + this.key();
  }

  _parsePresigning (response) {
    console.log('presigned url', response);
    if (response.ok) {
      this.state = 'presigned';
      return response.json();
    }
    this.state = 'presign_failed';
    this._notifyFailure();
  }

  _success (response) {
    if (!response.ok) return;
    console.log('upload success', response);
    this._notifySuccess();
  }

  _upload (presigningResponse) {
    if (presigningResponse == null) return;

    console.log('uploading to S3', presigningResponse);

    var headers = new Headers();
    headers.append('Content-Type', this.file.type);

    this.state = 'uploading';
    fetch(presigningResponse.presigned_url,
      {
        method: 'PUT',
        mode: 'cors',
        redirect: 'follow',
        headers: headers,
        body: this.file,
        credentials: 'include'
      })
        .catch(this._uploadFailure.bind(this))
        .then(this._uploaded.bind(this))
        .then(this._success.bind(this));
  }

  _uploaded (response) {
    console.log('upload complete', response);
    if (response.ok) {
      this.state = 'uploaded';
      return response;
    }
    this.state = 'upload_failed';
    this._notifyFailure();
  }

  _uploadFailure (err) {
    console.error('upload failure', err);
    this.state = 'upload_failed';
    this._notifyFailure();
  }
}
