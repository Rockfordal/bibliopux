"use strict";


exports.kalka = function(amount) {
    return amount * 0.1;
};

exports.msg = "hej";

exports.hej = function() {
    return "hej";
};

exports.alert = function(msg) {
    return function() {
        window.alert(msg);
    };
};

exports.leanmodal = function(ob) {
    return function() {
        ob.leanModal();
    };
};

exports.openleanmodal = function() {
    // return function() {
        // jQuery('.modal-trigger').leanModal();
        jQuery('#modal1').openModal();
        // alert('WTF');
    // };
};

// exports.leana = function(msg) {
//     return function() {
//         ob.leanModal();
//     };
//         window.alert(msg);
//     };
// };
