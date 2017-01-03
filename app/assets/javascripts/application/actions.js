{
    class Action {
        constructor (event) {
            this.event = event;
            this.target = event.target;
            event.preventDefault();
        }

        click() {
            console.log('clicked');
            var action = this.target.getAttribute('data-action');
            var target = document.querySelector(this.target.getAttribute('data-target'));
            console.log('target', target);

            if (action == 'open') this.open(target);
            if (action == 'close') this.close(target);
            return false;
        }

        close(target) {
            console.log('closing', target);
            target.classList.remove('open');
        }

        open(target) {
            console.log('opening', target);
            target.classList.add('open');
        }
    }


    if (window.archiver.actions === undefined) {
        window.archiver.actions = {
            click: function(e) {
                if (!e.target.matches('.action')) return;
                var action = new Action(e);
                action.click();
                return false;
            }
        }

        document.addEventListener('click', window.archiver.actions.click);
    }
}
