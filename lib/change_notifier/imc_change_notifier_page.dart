import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:state_manager/change_notifier/imc_change_notifier_controller.dart';
import 'package:state_manager/widgets/imc_gauge.dart';

class ChangeNotifierPage extends StatefulWidget {
  const ChangeNotifierPage({Key? key}) : super(key: key);

  @override
  _ChangeNotifierPageState createState() => _ChangeNotifierPageState();
}

class _ChangeNotifierPageState extends State<ChangeNotifierPage> {
  final controller = ImcChangeNotifierController();

  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
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
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) {
                    return ImcGauge(imc: controller.imc);
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: pesoEC,
                  decoration: InputDecoration(labelText: 'Peso'),
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
                  decoration: InputDecoration(labelText: 'Altura'),
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

                      controller.CalcularImc(peso: peso, altura: altura);
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
