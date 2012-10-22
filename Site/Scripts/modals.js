function setupModal (modalId) {
    $('#' + modalId).click(function () {
        $('#' + modalId+'-container').load(this.href, function () {
            $('#' + modalId + '-modal').modal({
                backdrop: 'static',
                keyboard: true
            }, 'show');
            bindForm(this,modalId);
        });
        return false;
    });
}

function bindForm(dialog, modalId) {
    $('form', dialog).submit(function () {
        $.ajax({
            url: this.action,
            type: this.method,
            data: $(this).serialize(),
            success: function (result) {
                if (result.success) {
                    $('#' + modalId + '-modal').modal('hide');
                    // Refresh:
                    // location.reload();
                } else {
                    $('#' + modalId + '-container').html(result);
                    bindForm();
                }
            }
        });
        return false;
    });
}