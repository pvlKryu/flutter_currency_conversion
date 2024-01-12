import 'package:flutter/material.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:  Text('Currency converter', style:TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'You send',
                style: TextStyle(fontSize: 18.0),
              ),
              Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        // hintText: 'Enter amount',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 50),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_downward_sharp,
                      size: 24.0,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Spacer(),
                    Expanded(
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.swap_vert,
                          size: 24.0,
                        ),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              const Text(
                'They get',
                style: TextStyle(fontSize: 18.0),
              ),
              Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        // hintText: 'Enter amount',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 50),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_downward_sharp,
                      size: 24.0,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
