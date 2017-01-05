{
    class ThingUploader {
        constructor(formSelector, fileSelector, prefix, assetPathSelector, contentTypeSelector) {
            this.form = document.querySelector(formSelector);
            this.fileForm = document.querySelector(fileSelector);
            this.prefix = prefix;
            this.assetPathSelector = assetPathSelector;
            this.contentTypeSelector = contentTypeSelector;

            this.fileInput = this.fileForm.querySelector('input[type=file]');
            this.label = this.fileForm.querySelector('label');
            this.label.setAttribute('data-original-caption', this.label.innerHTML);

            this.multiple = this.fileInput.hasAttribute('multiple');

            this.files = new Array();
            this.bind();
        }

        bind() {
            $$(document)
                .addEventListener('s3.upload.success', this.handleUploadSuccess.bind(this))
                .addEventListener('s3.upload.failure', this.handleUploadFailure.bind(this));

            $$(this.fileForm)
                .addEventListener('submit', this.stopBubble.bind(this))
                .addEventListener('submit', this.uploadFiles.bind(this))
                .addEventListener('reset', this.clear.bind(this))
                .addEventListener('drag dragstart dragend dragover dragenter dragleave drop', this.stopBubble)
                .addEventListener('dragover dragenter', this.startDrag.bind(this))
                .addEventListener('dragleave dragend drop', this.stopDrag.bind(this))
                .addEventListener('drop', this.handleDroppedFiles.bind(this))
                .addEventListener('drop', this.updateSubmit.bind(this))
                .addEventListener('drop', this.updateLabel.bind(this));

            $$(this.fileInput)
                .addEventListener('change', this.handleSelectedFiles.bind(this))
                .addEventListener('change', this.updateSubmit.bind(this))
                .addEventListener('change', this.updateLabel.bind(this));
        }

        //******************** UTIL
        //
        clear () {
            this.fileForm.classList.remove('uploading');
            this.fileForm.classList.remove('with_files');
            this.fileForm.classList.remove('success');
            this.fileForm.classList.remove('error');
            this.fileForm.reset();
            this.files = new Array();
            this.delay(this.updateSubmit.bind(this));
            this.delay(this.updateLabel.bind(this));
        }

        delay (callback, timeout) {
            if (timeout == undefined) timeout = 0;
            setTimeout(callback, timeout);
        }

        //******************** DROPPABLE
        //
        addFile (file) {
            if (this.multiple) {
                if (this.files.findIndex(function(f) { return f.name == file.name}) != -1) return;
            } else {
                this.files = new Array();
            }
            this.files.push(file);
        }

        removeFile (file) {
            var index = this.files.findIndex(function(f) { return f.name == file.name });
            if (index == -1) return;

            this.files.splice(index, 1);
        }

        handleDroppedFiles (e) {
            $$(e.dataTransfer.files).forEach(function(file) { this.addFile(file) }.bind(this));
        }

        handleSelectedFiles (e) {
            $$(this.fileInput.files).forEach(function(file) { this.addFile(file) }.bind(this));
        }

        startDrag (e) {
            this.fileForm.classList.add('dragover');
        }

        stopDrag (e) {
            this.fileForm.classList.remove('dragover');
        }

        stopBubble (e) {
            e.preventDefault();
            e.stopPropagation();
        }

        supportsDropFiles () {
            var div = document.createElement('div');
            return (('draggable' in div) || ('ondragstart' in div && 'ondrop' in div)) && 'FormData' in window && 'FileReader' in window;
        }

        updateSubmit (e) {
            if (this.files.length > 0) {
                this.fileForm.classList.add('with_files');
            } else {
                this.fileForm.classList.remove('with_files');
            }
        }

        updateLabel (e) {
            var files = this.files;
            var text = null;
            if (files.length > 1) {
                text = this.label.getAttribute('data-multiple-caption').
                    replace('{count}', files.length);
            } else if (files.length == 1) {
                text = files[0].name;
            } else {
                text = this.label.getAttribute('data-original-caption');
            }
            this.label.innerHTML = text;
        }

        uploadFiles () {
            if (this.fileForm.classList.contains('uploading')) return;

            this.fileForm.classList.add('uploading');

            this.files.forEach(function(file) {
                var uploader = new Uploader(this.prefix, file);
                uploader.upload();
            }.bind(this));
        }


        //******************** CALLBACK
        //
        finish () {
            this.delay(this.clear.bind(this), 2000);
        }

        handleUploadFailure (e) {
            this.fileForm.classList.add('error');
            console.error('UPLOAD FAILURE', e);
            this.finish();
        }

        handleUploadSuccess(e) {
            var uploader = e.detail.uploader;
            this.fileForm.classList.add('success');
            this.form.querySelector(this.assetPathSelector).value = uploader.key();
            this.form.querySelector(this.contentTypeSelector).value = uploader.contentType();
            this.finish();
        }
    }

    window.archiver.things = {
        initialize: function(formSelector, fileSelector, prefix, assetPathSelector, contentTypeSelector) {
            $$(document).ready(function() {
                new ThingUploader(formSelector, fileSelector, prefix, assetPathSelector, contentTypeSelector);
            });
        }
    }
}
