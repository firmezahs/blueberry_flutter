import 'package:ag_widgets/widgets/ag_app_button.dart';
import 'package:blueberry/main.dart';
import 'package:blueberry/utils/functions.dart';
import 'package:blueberry/view/orders/model/order_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class AddProductBottomSheet extends StatefulWidget {
  // final AddOrderStore store;
  final OrderItems? product;

  const AddProductBottomSheet({super.key, this.product});

  @override
  State<AddProductBottomSheet> createState() => _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends State<AddProductBottomSheet> {
  late final OrderItems p;
  late final bool isEdit;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    isEdit = widget.product != null;

    p = widget.product ?? OrderItems();

    if (isEdit) {
      if (p.product != null) {
        addOrderStore.productNameCont.text = p.product!.name.validate();
      }
      addOrderStore.quantityCont.text = p.quantity.validate().toString();
      addOrderStore.markingCont.text = p.marking.validate().toString();
      addOrderStore.packagingSelections.forEach((key, value) {
        p.packaging!.contains(key) ? addOrderStore.togglePackaging(key, true) : addOrderStore.togglePackaging(key, false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: MediaQuery.of(context).viewInsets.bottom + 16),
      child: Observer(
        builder: (_) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------- Header ----------------
                  Row(
                    children: [
                      Text(isEdit ? "Edit Product" : "Add Product", style: boldTextStyle(size: 22)).expand(),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => finish(context),
                      ),
                    ],
                  ),
                  16.height,

                  // ---------------- Fields ----------------
                  AppTextField(
                    title: "Product Name*",
                    controller: addOrderStore.productNameCont,
                    textFieldType: TextFieldType.NAME,
                    decoration: inputDecoration(hint: "Enter Product Name"),
                  ),

                  16.height,

                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          title: "Qty*",
                          controller: addOrderStore.quantityCont,
                          textFieldType: TextFieldType.NUMBER,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: inputDecoration(hint: "Qty"),
                        ),
                      ),
                      12.width,
                      Expanded(
                        child: AppTextField(
                          title: "Marking",
                          controller: addOrderStore.markingCont,
                          textFieldType: TextFieldType.NAME,
                          isValidationRequired: false,
                          decoration: inputDecoration(hint: "Enter Marking"),
                        ),
                      ),
                    ],
                  ),

                  16.height,
                  Text("Packaging Options*", style: boldTextStyle()),

                  8.height,

                  // ---------------- Packaging ----------------
                  ...addOrderStore.packagingSelections.entries.map((e) {
                    return CheckboxListTile(
                      value: e.value,
                      title: Text(e.key),
                      onChanged: (v) {
                        hideKeyboard(context);
                        addOrderStore.togglePackaging(e.key, v ?? false);
                      },
                      dense: true,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      contentPadding: EdgeInsets.zero,
                    );
                  }),

                  30.height,

                  // ---------------- Action ----------------
                  Observer(
                    builder: (context) {
                      return AgAppButton(
                        width: double.infinity,
                        solidColor: context.primaryColor,
                        text: isEdit ? "Update Product" : "Add Product",
                        borderRadius: defaultRadius,

                        isLoading: addOrderStore.isLoading,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            if (isEdit) {
                              addOrderStore.editProduct(p.currentIndex.validate());
                            } else {
                              addOrderStore.addProduct();
                            }
                            finish(context);
                          }
                        },
                      );
                    },
                  ),
                  108.height,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
