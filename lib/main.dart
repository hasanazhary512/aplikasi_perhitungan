import 'package:flutter/material.dart';

void main() {
  runApp(const AplikasiTabunganApp());
}

class AplikasiTabunganApp extends StatelessWidget {
  const AplikasiTabunganApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Tabungan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HalamanTabungan(),
    );
  }
}

class HalamanTabungan extends StatefulWidget {
  const HalamanTabungan({super.key});

  @override
  State<HalamanTabungan> createState() => _HalamanTabunganState();
}

class _HalamanTabunganState extends State<HalamanTabungan> {
  int _totalSaldo = 0;
  final TextEditingController _nominalController = TextEditingController();

  void _menabung() {
    final String input = _nominalController.text;
    if (input.isNotEmpty) {
      final int nominal = int.tryParse(input) ?? 0;
      if (nominal > 0) {
        setState(() {
          _totalSaldo += nominal;
        });
        _nominalController.clear();
        _tampilkanPesan('Berhasil menambah saldo Rp $nominal');
      }
    } else {
      _tampilkanPesan('Masukkan nominal terlebih dahulu!');
    }
  }

  void _tarikSaldo() {
    final String input = _nominalController.text;
    if (input.isNotEmpty) {
      final int nominal = int.tryParse(input) ?? 0;
      if (nominal > 0) {
        if (nominal <= _totalSaldo) {
          setState(() {
            _totalSaldo -= nominal;
          });
          _nominalController.clear();
          _tampilkanPesan('Berhasil menarik saldo Rp $nominal');
        } else {
          _tampilkanPesan('Saldo tidak mencukupi!');
        }
      }
    } else {
      _tampilkanPesan('Masukkan nominal terlebih dahulu!');
    }
  }

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan)),
    );
  }

  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Tabungan Saya'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.green.shade50,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Total Saldo Saat Ini:',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rp $_totalSaldo',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nominalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Masukkan Nominal (Rp)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _menabung,
                    icon: const Icon(Icons.add),
                    label: const Text('Menabung'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _tarikSaldo,
                    icon: const Icon(Icons.remove),
                    label: const Text('Tarik Saldo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}