function clickStarter () {
      
      var token = function(res) {
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
        plan: 		 'starter',
        panelLabel:  'Subscribe',
        token:       token
      });

      return false;
};