import 'dart:async';
import 'package:flutter/material.dart';

enum PaymentEvent {
  ValidateForm,
  SubmitPayment,
}

class PaymentBloc {
  final _formValidController = StreamController<bool>.broadcast();
  final _eventController = StreamController<PaymentEvent>();

  Stream<bool> get formValidStream => _formValidController.stream;

  Function(PaymentEvent) get sendEvent => _eventController.sink.add;

  PaymentBloc() {
    _eventController.stream.listen(_handleEvent);
  }

  void dispose() {
    _formValidController.close();
    _eventController.close();
  }

  void _handleEvent(PaymentEvent event) {
    if (event == PaymentEvent.ValidateForm) {
      
      _formValidController.sink.add(true); 
    } else if (event == PaymentEvent.SubmitPayment) {
       
      print('Payment submitted');
    }
  }

  void init() {}
}
