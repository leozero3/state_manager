import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:state_manager/bloc_pattern/imc_bloc_pattern_controller.dart';
import 'package:state_manager/bloc_pattern/imc_state.dart';
import 'package:state_manager/widgets/imc_gauge.dart';

class ImcBlocPatternPage extends StatefulWidget {
  const ImcBlocPatternPage({Key? key}) : super(key: key);

  @override
  _ImcBlocPatternPageState createState() => _ImcBlocPatternPageState();
}

class _ImcBlocPatternPageState extends State<ImcBlocPatternPage> {
  final controller = ImcBlocPatternController();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imc SetState'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                StreamBuilder<ImcState>(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {
                    var imc = 0.0;
                    imc = snapshot.data?.imc ?? 0;

                    return ImcGauge(imc: imc);
                  },
                ),
                const SizedBox(height: 20),
                StreamBuilder<ImcState>(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {
                    return Visibility(
                      visible: snapshot.data is ImcStateLoading,
                      child: const CircularProgressIndicator(),
                    );
                  },
                ),
                TextFormField(
                  controller: pesoEC,
                  decoration: const InputDecoration(labelText: 'Peso'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      decimalDigits: 2,
                      turnOffGrouping: true,
                    ),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Obrigatorio';
                    }
                  },
                ),
                TextFormField(
                  controller: alturaEC,
                  decoration: const InputDecoration(labelText: 'Altura'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR',
                      symbol: '',
                      decimalDigits: 2,
                      turnOffGrouping: true,
                    ),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo Obrigatorio';
                    }
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    var formValid = formKey.currentState?.validate() ?? false;

                    if (formValid) {
                      var formatter = NumberFormat.simpleCurrency(
                          locale: 'pt_BR', decimalDigits: 2);
                      double peso = formatter.parse(pesoEC.text) as double;
                      double altura = formatter.parse(alturaEC.text) as double;

                      controller.calcularImc(peso: peso, altura: altura);
                    }
                  },
                  child: const Text('Calcular IMC'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
