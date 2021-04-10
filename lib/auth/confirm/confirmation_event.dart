abstract class ConfirmationEvent{}

class ConfirmationCodeChanged extends ConfirmationEvent{
  final String confirmation_code;
  ConfirmationCodeChanged({this.confirmation_code});
}

class ConfirmationSubmitted extends ConfirmationEvent{}