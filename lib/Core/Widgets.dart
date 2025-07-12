import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatefulWidget {
  final TextEditingController? icontroller;
  final TextInputFormatter? iformatter;
  final Function(String)? ichanged;
  final TextInputType? ikeyboardType;
  final Widget? isuffixIcon;
  final int? iMaxLength;
  final bool? isDisabled;
  final String? iInit;
  final String? iHint;
  final String? Function(String?)? iValid;
  final Widget? iprefix;
  final bool? isRead;
  final Function()? iTap;
  final FocusNode? focusNode;
  final TextAlign? iAlign;
  final BorderSide? border;
  const InputWidget({super.key, this.icontroller, this.iformatter, this.ichanged, this.ikeyboardType, this.isuffixIcon, this.iMaxLength, this.isDisabled, this.iInit, this.iValid, this.iHint, this.iprefix, this.isRead, this.iTap, this.focusNode, this.iAlign, this.border});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      onTap: widget.iTap,
      readOnly: widget.isRead ?? false,
      initialValue: widget.iInit,
      // inputFormatters: [widget.iformatter],
      validator: widget.iValid,
      enabled: widget.isDisabled,
      keyboardType: widget.ikeyboardType,
      maxLength: widget.iMaxLength,
      onChanged: widget.ichanged,
      cursorColor: Color(0xFF4F67FF),
      controller: widget.icontroller,
      textAlign: widget.iAlign ?? TextAlign.start,
      decoration:  InputDecoration(
        border: OutlineInputBorder(borderSide: widget.border ?? BorderSide.none,),
        enabledBorder: OutlineInputBorder(borderSide: widget.border ?? BorderSide.none,),
        disabledBorder: OutlineInputBorder(borderSide: widget.border ?? BorderSide.none,),
        focusedBorder: OutlineInputBorder(borderSide: widget.border ?? BorderSide.none,),
        counterText: "",
        hintText: widget.iHint,
        filled: true,
        fillColor: Color(0xFFF7F7F7),
        suffixIcon: widget.isuffixIcon,
        prefixIcon: widget.iprefix,
      ),);
  }
}


class ButtonWidget extends StatefulWidget {
  final String? btnText;
  final IconData? bIcon;
  final bool? isDisabled;
  const ButtonWidget({super.key, this.btnText, this.isDisabled, this.bIcon});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
          alignment: Alignment.center,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 12,),
          decoration: BoxDecoration(color: widget.isDisabled == false ? Color(0xFF8F91A0) : Color(0xFF4F66FE),borderRadius: BorderRadius.circular(10)),
          child: widget.bIcon != null ? Icon(widget.bIcon, color: Colors.white,size: 27,) : Text(widget.btnText!, style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.bold),),
        );
  }
}
