abstract class ForgotPasswordEvent {
  @override
  List<Object> get props => [];
}

class ForgotPasswordSubmitted extends ForgotPasswordEvent {
  final String email;
  ForgotPasswordSubmitted(this.email);

  @override
  List<Object> get props => [email];
}