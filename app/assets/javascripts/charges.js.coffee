# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('#starter').click(function(){
      var token = function(res){
        var $input = $('<input type=hidden name=stripeToken />').val(res.id);
        $('form').append($input).submit();
      };

      StripeCheckout.open({
        key:         'pk_HZUVpGYMdMTUSTtveLSuL6Vs4Zudk',
        address:     false,
        amount:      199,
        currency:    'usd',
        name:        'KeyPal Starter',
        description: 'The starter plan for KeyPal',
        plan: 		 'starter'
        panelLabel:  'Checkout',
        token:       token
      });

      return false;
    });