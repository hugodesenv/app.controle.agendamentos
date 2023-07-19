/// author: Hugo Silva de Souza, 19/07/2023 00h03
class ProductNewEvent {}

/// call the camera to the user "beep" them barcodes or qr codes from products
class OpenCameraBarcodeEvent extends ProductNewEvent {}

/// when the submit occurs, we notify the bloc to save the data in database
class SubmitEvent extends ProductNewEvent {}
