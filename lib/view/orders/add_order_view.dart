import 'dart:io';

import 'package:ag_widgets/widgets/ag_app_button.dart';
import 'package:ag_widgets/widgets/ag_view_all_button.dart';
import 'package:blueberry/main.dart';
import 'package:blueberry/utils/colors.dart';
import 'package:blueberry/utils/functions.dart';
import 'package:blueberry/view/orders/model/order_response.dart';
import 'package:blueberry/view/orders/widget/product_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import 'add_product_bottom_sheet.dart';

class AddOrderScreen extends StatefulWidget {
  final OrderData? order;
  AddOrderScreen({super.key, this.order});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  bool isEdit = false;

  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    isEdit = widget.order != null;
    if (isEdit) {
      addOrderStore.customerNameCont.text = widget.order!.customerName.validate();
      addOrderStore.notesCont.text = widget.order!.note.validate();
      addOrderStore.isUrgent = widget.order!.isUrgent.validate();
      addOrderStore.products = widget.order!.orderItems.validate().asObservable();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${isEdit ? 'Edit' : 'Create'} Order", style: boldTextStyle(size: 18)), centerTitle: false),
      bottomNavigationBar: Row(
        children: [
          AgAppButton(
            text: "Cancel",
            borderRadius: defaultRadius,

            onPressed: () {
              finish(context);
              addOrderStore.dispose();
            },
            solidColor: context.primaryColor,
            borderColor: context.primaryColor,
            isOutlined: true,
          ).expand(),
          16.width,
          Observer(
            builder: (context) {
              return AgAppButton(
                borderRadius: defaultRadius,
                text: isEdit ? "Update Order" : "Submit Order",

                isLoading: addOrderStore.isLoading,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if (isEdit) {
                      addOrderStore.editOrder(orderId: widget.order!.id.validate());
                    } else {
                      addOrderStore.submitOrder();
                    }
                  }
                },
                solidColor: context.primaryColor,
              ).expand();
            },
          ),
        ],
      ).paddingSymmetric(horizontal: 16, vertical: 8 + (Platform.isIOS ? 20 : 0)),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: AnimatedScrollView(
          listAnimationType: ListAnimationType.None,
          padding: EdgeInsets.all(16),
          children: [
            AppTextField(
              title: "Customer Name",
              titleTextStyle: boldTextStyle(),
              textFieldType: TextFieldType.NAME,
              onTapOutside: (event) {
                hideKeyboard(context);
              },
              controller: addOrderStore.customerNameCont,
              decoration: inputDecoration(hint: "e.g. Global Corp"),
            ),
            16.height,
            Observer(
              builder: (context) {
                return SwitchListTile(
                  value: addOrderStore.isUrgent,
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  tileColor: appTextFiledFilledColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: radius(),
                    side: BorderSide(color: context.dividerColor),
                  ),
                  activeThumbColor: context.theme.colorScheme.error,
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  onChanged: addOrderStore.toggleUrgent,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  title: Text("Urgent Order", style: boldTextStyle()),
                  subtitle: Text("Mark as high priority", style: secondaryTextStyle(size: 12)),
                );
              },
            ),
            16.height,
            AgViewAllButton(
              title: "Products",
              padding: EdgeInsets.zero,
              hideViewAllIcon: false,
              viewAllText: "Add Products",
              onTap: () {
                hideKeyboard(context);
                _openAddProductSheet(context);
              },
            ),
            8.height,
            Container(
              padding: EdgeInsets.all(8),
              width: context.width(),
              decoration: BoxDecoration(
                color: appTextFiledFilledColor,
                borderRadius: radius(),
                border: Border.all(color: context.dividerColor),
              ),
              child: Observer(
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (addOrderStore.products.isNotEmpty)
                        ...List.generate(addOrderStore.products.length, (index) {
                          OrderItems data = addOrderStore.products[index];
                          return ProductSummaryCard(
                            product: data,
                            onEdit: () {
                              data.currentIndex = index;
                              _openAddProductSheet(context, product: data);
                            },
                            onDelete: () {
                              addOrderStore.removeProduct(index);
                            },
                          );
                        })
                      else ...{
                        NoDataWidget(title: "No products added yet").paddingBottom(16),
                      },
                    ],
                  );
                },
              ),
            ),
            16.height,
            AppTextField(
              title: "Notes",
              textFieldType: TextFieldType.MULTILINE,
              controller: addOrderStore.notesCont,
              isValidationRequired: false,
              onTapOutside: (event) {
                hideKeyboard(context);
              },
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: inputDecoration(hint: "Additional instructions..."),
            ),
          ],
        ),
      ),
    );
  }

  void _openAddProductSheet(BuildContext context, {OrderItems? product}) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(defaultRadius))),
      builder: (_) => AddProductBottomSheet(product: product),
    );
  }
}
