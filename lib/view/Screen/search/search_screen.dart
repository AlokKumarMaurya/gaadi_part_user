
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../utill/dimensions.dart';
import '../../baseWidget/search_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
  void addHis(BuildContext context,text){
    Provider.of<SearchHistory>(context, listen: false).addHis(text);
  }

  void deleteHis(BuildContext context){
    Provider.of<SearchHistory>(context, listen: false).deleteHis();
  }

  List getSearchHis = Provider.of<SearchHistory>(context).History;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF9F9F9),
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Theme.of(context).canvasColor,
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1, blurRadius: 3, offset: Offset(0, 1),)],
              ),
              child: Row(children: [
                Padding(padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                  child: InkWell(onTap: ()=>Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios)),),


                Expanded(child: Container(
                  child: SearchWidget(
                    hintText: 'SEARCH_HINT',
                    onSubmit: (String text) {
                      print("324324rwerw"+text);
                      if(text.trim().isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'enter_somethings',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('enter_somethings'), backgroundColor: ColorResources.getRed(context)));

                      }else{
                        setState((){
                          print("324324rwerw"+text);
                          addHis(context, text);
                          print(getSearchHis);
                        });

                      }},
                    onClearPressed: (){},
                  ),
                ),
                ),
              ],
              ),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),

            Expanded(
                  child: Padding( padding: EdgeInsets.symmetric(horizontal:  Dimensions.PADDING_SIZE_LARGE),
                    child: Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('SEARCH_HISTORY',),


                            InkWell(borderRadius: BorderRadius.circular(10),
                                onTap: (){
                                  setState(() {
                                    deleteHis(context);
                                  });
                                },
                                child: Container(padding: EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_DEFAULT,
                                    vertical:Dimensions.PADDING_SIZE_LARGE ),
                                    child: Text('REMOVE', style: TextStyle(fontSize: Dimensions.FONT_SIZE_SMALL,
                                        color: Theme.of(context).primaryColor)),
                                      ))
                          ],
                        ),
                        Expanded(
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: getSearchHis.length,
                            itemBuilder: (context, index) => Container(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                                        color: Color(0xFFF1F1F1)),
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(getSearchHis[index],
                                        style: TextStyle(fontSize: Dimensions.FONT_SIZE_DEFAULT),
                                      ),
                                    ),
                                  ),
                                )),
                            staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
          ],
        ),
      ),
    );
  }
}

class SearchHistory extends ChangeNotifier{
  List searchHistory = [];

  List get History => searchHistory;

  void addHis(text){
    searchHistory.add(text);
    notifyListeners();
  }
  void deleteHis(){
    searchHistory.clear();
    notifyListeners();
  }
}