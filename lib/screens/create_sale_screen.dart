import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_firebase_flutter/models/sale.dart';
import 'package:sales_firebase_flutter/services/firebase_services.dart';

class CreateSaleScreen extends StatefulWidget {

  Map<String, dynamic>? sale;
  String? id;

  CreateSaleScreen({this.sale, this.id, Key? key}) : super(key: key);

  @override
  State<CreateSaleScreen> createState() => _CreateSaleScreenState();
}

class _CreateSaleScreenState extends State<CreateSaleScreen> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  String _selectedPaymentMethod = 'Efectivo';
  String selectedClient = '';
  DateTime _selectedDate = DateTime.now();
  DateTime _currentDate = DateTime.now();
  String showDate = '';
  FirestoreService service = FirestoreService();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();

    if (widget.sale != null){
      _nameController.text = widget.sale!['productName'];
      _valueController.text = widget.sale!['price'].toString();
      _selectedPaymentMethod = widget.sale!['paymentMethod'];
      selectedClient = widget.sale!['client'];
      showDate = widget.sale!['paymentDate'];
      _selectedDate = DateTime.parse(showDate);
      isEdit = true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void clearData() {
    _nameController.clear();
    _valueController.clear();
    _selectedPaymentMethod = 'Efectivo';
    selectedClient = 'No seleccionado';
    _selectedDate = DateTime.now();
    _currentDate = DateTime.now();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Venta'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nombre del producto'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresar el nombre';
                    }
                    return null;
                  },
                ),
        
                const SizedBox(height: 16.0),
                
                TextFormField(
                  controller: _valueController,
                  decoration: const InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresar el valor';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16.0),


                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return [
                      'Juan Pérez',
                      'María García',
                      'Pedro Sánchez',
                      'Ana López',
                      'José Rodríguez',
                      'Isabel Martínez',
                      'Antonio Fernández',
                      'Carmen González',
                      'David Hernández',
                      'Laura Gómez',
                      'Javier Gutiérrez',
                      'Sandra Ruiz',
                      'Miguel Torres',
                      'Elena Alonso',
                      'Carlos Blanco',
                      'Patricia Sánchez',
                      'Daniel García',
                      'Mónica López',
                      'Rafael Fernández',
                      'Sara Martínez',
                    ].where((client) => client.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                  },
                  onSelected: (client) {
                    setState(() {
                      selectedClient=client;
                    });
                  },
                  
                ),
                
                const SizedBox(height: 16.0),
        
                Column(
                  children: [
                    ListTile(
                      title: const Text('Efectivo'),
                      leading: Radio<String>(
                        value: 'Efectivo',
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Tarjeta de débito'),
                      leading: Radio<String>(
                        value: 'Tarjeta debito',
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Tarjeta de crédito'),
                      leading: Radio<String>(
                        value: 'Tarjeta credito',
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16.0),
        
                TextButton(
                  onPressed: ()  async {

                    final datePicker = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2030),
                    );

                    if (datePicker != null) {
                      setState(() {
                        _currentDate = datePicker;
                        showDate = DateFormat('yyyy-MM-dd').format(_currentDate);
                        _selectedDate = datePicker;
                      });
                    }

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Fecha: $showDate '),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),

                const SizedBox(height: 16.0),
        
                ElevatedButton(
                  onPressed: () async {
                    // Implementar la lógica para procesar el pago
                    if (_formKey.currentState!.validate()){  
                      
                      if (!selectedClient.trim().isNotEmpty) {
                        showDialog(
                          context: context, 
                          builder: (context) => AlertDialog(
                            title: const Text('Advertencia'),
                            content: const Text('Por favor Escribe el nombre de un cliente para seleccionarlo.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cerrar'),
                              ),
                            ],
                          )
                        ); 
                      } else {
                        Sale sale = Sale.withoutId(
                          productName: _nameController.text,
                          value: int.parse(_valueController.text),
                          client: selectedClient,
                          paymentMethod: _selectedPaymentMethod,
                          paymentDate:  DateFormat('yyyy-MM-dd').format(_currentDate),
                        ); 

                        try{ 

                          if (isEdit){
                            
                            await service.updateSale(sale, widget.id);

                            if (context.mounted){
                              showDialog(
                                context: context, 
                                builder: (context) => AlertDialog(
                                  title: const Text('Excelente!'),
                                  content: const Text('Venta modificada'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cerrar'),
                                    ),
                                  ],
                                )
                              );
                            }
                            
                          } else {

                            await service.createSale(sale);

                            if (context.mounted){
                              showDialog(
                                context: context, 
                                builder: (context) => AlertDialog(
                                  title: const Text('Excelente!'),
                                  content: const Text('Venta creada'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cerrar'),
                                    ),
                                  ],
                                )
                              );
                            }

                          }

                          setState(() {
                            clearData();
                          });

                        } catch (e) {

                          if (context.mounted){
                            showDialog(
                              context: context, 
                              builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: Text(e.toString()),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cerrar'),
                                  ),
                                ],
                              )
                            );
                          }

                        }


                        
                      }
                    }
                  },
                  child: const Text('Guardar'),
                ),
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}




