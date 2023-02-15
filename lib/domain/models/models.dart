// onBoarding models

class SliderObject {
  final String title;
  final String subtitle;
  final String image;
  // TODO: remeber delete or edit
  // height & width for image
  final double imgHeight;
  final double imgWidth;

  SliderObject(this.title, this.subtitle, this.image, this.imgHeight, this.imgWidth);
}

class SliderViewObject{

  final SliderObject sliderObject;
  final int numOfSlides;
  final int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);

}

// login models

class AuthenticationModel{
  // because the the type is not primitive so it better to make it nullable
  final CustomerModel? customer;
  final ContactModel? contact;

  AuthenticationModel(this.customer, this.contact);
}

class CustomerModel{
  final String id;
  final String name;
  final int numOfNotificatione;

  CustomerModel(this.id, this.name, this.numOfNotificatione);
}

class ContactModel{
  final String phone;
  final String email;
  final String link;

  ContactModel(this.phone, this.email, this.link);
}