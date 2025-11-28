$(function() {


    var $form = $("#payment-form");

    $('form#payment-form').bind('submit', function(e) {
        var $form = $("#payment-form"),
            inputSelector = ['input[type=email]', 'input[type=password]',
                'input[type=text]', 'input[type=file]',
                'textarea'].join(', '),
            $inputs = $form.find('.required').find(inputSelector),
            $errorMessage = $form.find('div.error-message-div'),
            valid = true;
        $errorMessage.addClass('hide');

        $('.has-error').css('has-error');
        $inputs.each(function(i, el) {
            var $input = $(el);
            if ($input.val() === '') {
                $input.parent().addClass('has-error');
                $errorMessage.removeClass('hide');
                e.preventDefault();
            }
        });

        if (!$form.data('cc-on-file')) {
            e.preventDefault();
            Stripe.setPublishableKey($form.data('stripe-publishable-key'));
            Stripe.createToken({
                number: $('#card-number').val(),
                name: $('#card-name').val(),
                cvc: $('#card-cvv').val(),
                exp_month: $('#expire-month').val(),
                exp_year: $('#expire-year').val()
            }, stripeResponseHandler);
        }


    });

    function stripeResponseHandler(status, response) {
        if (response.error) {
            $('.error-message-div')
                .css('display', 'block')
                .find('.alert')
                .text(response.error.message);
        } else {
            /* token contains id, last4, and card type */
            var token = response['id'];

            $form.find('input[type=text]').empty();
            $form.append("<input type='hidden' name='stripeToken' value='" + token + "'/>");
            $form.get(0).submit();
        }
    }

});
