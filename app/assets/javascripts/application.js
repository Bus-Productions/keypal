// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .


$('#starter').click( function() {
      
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
        panelLabel:  'Checkout',
        token:       token
      });

      return false;
    });