import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppMasks {
  static final cpfMask = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  String cpfMaskWithInitialValue(String value) => MaskTextInputFormatter(
        mask: '###.###.###-##',
        filter: {'#': RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy,
        initialText: value,
      ).getMaskedText();

  static final cnpjMask = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final cepMask = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final dateMask = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final timeMask = MaskTextInputFormatter(
    mask: '##:##',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final phoneMask = MaskTextInputFormatter(
    mask: '(##) #########',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
}
