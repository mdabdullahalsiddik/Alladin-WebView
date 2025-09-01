import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ndpl/app/global_widgets/app_text.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  void _copyText(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copied: $text'), duration: const Duration(seconds: 2)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// ✅ Mobile Banking Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.smartphone, size: 20),
                        SizedBox(width: 8),
                        CustomText('Mobile Banking', size: 18, weight: FontWeight.bold),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText('bKash :', size: 16, weight: FontWeight.bold),
                        Row(
                          children: [
                            const CustomText('01975580600', size: 16),
                            IconButton(icon: const Icon(Icons.copy, size: 18), onPressed: () => _copyText(context, '01975580600')),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText('Nagad :', size: 16, weight: FontWeight.bold),
                        Row(
                          children: [
                            const CustomText('01975580600', size: 16),
                            IconButton(icon: const Icon(Icons.copy, size: 18), onPressed: () => _copyText(context, '01975580600')),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    const CustomText('Send money to these numbers and save your transaction ID.', size: 14),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// ✅ DBBL Bank Transfer Card (Updated from Image)
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.account_balance, size: 20),
                        SizedBox(width: 8),
                        CustomText('Bank Transfer', size: 18, weight: FontWeight.bold),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Image.network("https://www.dutchbanglabank.com/img/logo-footer.png", height: 50, width: 50),
                        const SizedBox(width: 8),
                        const CustomText('Dutch Bangla Bank', size: 18, weight: FontWeight.bold),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Account Number
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText('Account No :', size: 16, weight: FontWeight.bold),
                        Row(
                          children: [
                            const CustomText('1377100841438', size: 16),
                            IconButton(icon: const Icon(Icons.copy, size: 18), onPressed: () => _copyText(context, '1377100841438')),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Account Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        CustomText('Account Name :', size: 16, weight: FontWeight.bold),
                        Flexible(child: CustomText('Natural Development Project Ltd.', size: 16)),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Branch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        CustomText('Branch :', size: 16, weight: FontWeight.bold),
                        CustomText('Sadar Bazar Branch', size: 16),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Swift Code
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        CustomText('SWIFT Code :', size: 16, weight: FontWeight.bold),
                        CustomText('DBBLBDDH', size: 16),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Routing Number
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText('Routing No :', size: 16, weight: FontWeight.bold),
                        Row(
                          children: [
                            const CustomText('090261322', size: 16),
                            IconButton(icon: const Icon(Icons.copy, size: 18), onPressed: () => _copyText(context, '090261322')),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    const CustomText('Please transfer to this account and save your transaction receipt.', size: 14),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
