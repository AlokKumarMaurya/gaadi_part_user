import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../baseWidget/botton/custom_button.dart';
import '../../baseWidget/textField/custom_textfield.dart';

class ReviewBottomSheet extends StatefulWidget {
  final String productID;
  final Function callback;
  ReviewBottomSheet({@required this.productID, @required this.callback});

  @override
  _ReviewBottomSheetState createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  final TextEditingController _controller = TextEditingController();
  List<File> _files = [File(''), File(''), File('')];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [

        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(Icons.cancel, color: Colors.red,),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        Text('review_your_experience', style: titilliumRegular),
        Divider(height: 5),

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Row(children: [
            Expanded(child: Text('your_rating',
                style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL))),
            Container(
              height: 30,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Icon(Icons.star, size: 20,
                      color: Theme.of(context).highlightColor,
                    ),
                    // onTap: () => Provider.of<ProductDetailsProvider>(context, listen: false).setRating(index+1),
                  );
                },
              ),
            ),
          ]),
        ),

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: CustomTextField(
            maxLine: 4,
            hintText: 'write_your_experience_here',
            controller: _controller,
            textInputAction: TextInputAction.done,
            fillColor: Colors.greenAccent,
          ),
        ),

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Row(children: [
            Expanded(child: Text('upload_images',
                style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL))),
            SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                    child: InkWell(
                      onTap: () async {
                        if(index == 0 || _files[index-1].path.isNotEmpty) {
                          ImagePicker imagePicker = ImagePicker();
                          XFile pickedFile = await imagePicker.pickImage(source: ImageSource.gallery,
                              maxWidth: 500, maxHeight: 500, imageQuality: 50);
                          if(pickedFile != null) {
                            _files[index] = File(pickedFile.path);
                            setState(() {});
                          }
                        }
                      },
                      child: _files[index].path.isEmpty ? Container(
                        height: 40,
                        width: 50,
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Icon(Icons.cloud_upload_outlined, color: Theme.of(context).primaryColor),
                            CustomPaint(
                              size: Size(100, 40),
                              foregroundPainter: new MyPainter(completeColor: Colors.blueAccent, width: 2),
                            ),
                          ],
                        ),
                      ) : ClipRRect(borderRadius: BorderRadius.circular(5),
                          child: Image.file(_files[index], height: 50, width: 50, fit: BoxFit.cover)),
                    ),
                  );
                },
              ),
            ),
          ]),
        ),

        // Provider.of<ProductDetailsProvider>(context).errorText != null ?
        Text("Provider.of<ProductDetailsProvider>(context).errorText",
            style: titilliumRegular.copyWith(color: Colors.red)),

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: CustomButton(
            buttonText: 'submit',
            onTap: () {
              // if(Provider.of<ProductDetailsProvider>(context, listen: false).rating == 0) {
              //   Provider.of<ProductDetailsProvider>(context, listen: false).setErrorText('Add a rating');
              // }else if(_controller.text.isEmpty) {
              //   Provider.of<ProductDetailsProvider>(context, listen: false).setErrorText('Write something');
              // }else {
              //   Provider.of<ProductDetailsProvider>(context, listen: false).setErrorText('');
              //   ReviewBody reviewBody = ReviewBody(
              //     productId: widget.productID,
              //     rating: Provider.of<ProductDetailsProvider>(context, listen: false).rating.toString(),
              //     comment: _controller.text.isEmpty ? '' : _controller.text,
              //   );
              //   Provider.of<ProductDetailsProvider>(context, listen: false).submitReview(reviewBody,
              //       _files, Provider.of<AuthProvider>(context, listen: false).getUserToken()).then((value) {
              //     if(value.isSuccess) {
              //       Navigator.pop(context);
              //       widget.callback();
              //       FocusScopeNode currentFocus = FocusScope.of(context);
              //       if (!currentFocus.hasPrimaryFocus) {
              //         currentFocus.unfocus();
              //       }
              //       _controller.clear();
              //     }else {
              //       // Provider.of<ProductDetailsProvider>(context, listen: false).setErrorText(value.message);
              //     }
              //   });
              // }
            },
          ),
        )

      ]),
    );
  }
}

class MyPainter extends CustomPainter {
  Color lineColor =  Colors.transparent;
  Color completeColor;
  double width;
  MyPainter({this.completeColor, this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    var percent = (size.width *0.001) / 2;
    double arcAngle = 2 * pi * percent;

    for (var i = 0; i < 8; i++) {
      var init = (-pi / 2)*(i/2);
      canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), init, arcAngle, false, complete);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
