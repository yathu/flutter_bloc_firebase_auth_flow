abstract class ConfirmationEvent{}

class ConfirmationCodeChanged extends ConfirmationEvent{
  final String confirmationCode;
  ConfirmationCodeChanged({this.confirmationCode});
}

class ConfirmationSubmitted extends ConfirmationEvent{}