import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  // Customer is optional — null means "Walk-in / No customer"
  String? _selectedCustomer;

  static const _customers = [
    'Anand Kirana Stores',
    'Bharath Hardware',
    'Citylight Electricals',
    'Devi Provision',
    'Everest Mart',
  ];

  final List<_InvoiceItem> _items = [
    _InvoiceItem(name: 'Basmati Rice 25kg', price: 1850.0, qty: 2),
    _InvoiceItem(name: 'Sunflower Oil 5L', price: 850.0, qty: 3),
  ];

  double get _subtotal => _items.fold(0, (sum, i) => sum + i.price * i.qty);
  double get _gst => _subtotal * 0.18;
  double get _total => _subtotal + _gst;

  void _openCustomerPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CustomerPickerSheet(
        customers: _customers,
        selected: _selectedCustomer,
        onSelect: (c) => setState(() => _selectedCustomer = c),
        onClear: () => setState(() => _selectedCustomer = null),
      ),
    );
  }

  void _addItem() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddItemSheet(
        onAdd: (item) => setState(() => _items.add(item)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: Stack(
        children: [
          Container(height: 220, decoration: const BoxDecoration(gradient: AppColors.headerGradient)),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 140),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _buildCustomerCard(),
                        const SizedBox(height: 16),
                        _buildItemsSection(),
                        const SizedBox(height: 16),
                        _buildTotalsCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'New Invoice',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.more_horiz_rounded, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerCard() {
    return GestureDetector(
      onTap: _openCustomerPicker,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 16, offset: const Offset(0, 6))],
          border: _selectedCustomer != null
              ? Border.all(color: AppColors.primary.withOpacity(0.4), width: 1.5)
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _selectedCustomer != null ? AppColors.infoLight : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                _selectedCustomer != null ? Icons.person_rounded : Icons.person_add_outlined,
                color: _selectedCustomer != null ? AppColors.primary : AppColors.textMuted,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Customer',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _selectedCustomer ?? 'Walk-in Customer (optional)',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: _selectedCustomer != null ? FontWeight.w700 : FontWeight.w500,
                      color: _selectedCustomer != null ? AppColors.textPrimary : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            if (_selectedCustomer != null)
              GestureDetector(
                onTap: () => setState(() => _selectedCustomer = null),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.errorLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.close_rounded, size: 14, color: AppColors.error),
                ),
              )
            else
              const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Items',
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                GestureDetector(
                  onTap: _addItem,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.add_rounded, color: Colors.white, size: 16),
                        const SizedBox(width: 4),
                        Text('Add', style: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Table header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text('ITEM', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.w700)),
                ),
                Expanded(
                  child: Center(child: Text('QTY', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.w700))),
                ),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('TOTAL', style: GoogleFonts.inter(fontSize: 10, color: AppColors.textMuted, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ..._items.asMap().entries.map((e) => _itemRow(e.key, e.value)),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _itemRow(int index, _InvoiceItem item) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
          child: Column(
            children: [
              // Line 1: name + total amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                    ),
                  ),
                  Text(
                    '₹${(item.price * item.qty).toStringAsFixed(0)}',
                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Line 2: unit price + stepper + delete
              Row(
                children: [
                  Text(
                    '₹${item.price.toStringAsFixed(0)}/unit',
                    style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMuted),
                  ),
                  const Spacer(),
                  // Qty stepper
                  GestureDetector(
                    onTap: () => setState(() { if (item.qty > 1) item.qty--; }),
                    child: Container(
                      width: 28, height: 28,
                      decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.remove_rounded, size: 14, color: AppColors.textSecondary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '${item.qty}',
                      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => item.qty++),
                    child: Container(
                      width: 28, height: 28,
                      decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.add_rounded, size: 14, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => setState(() => _items.removeAt(index)),
                    child: const Icon(Icons.delete_outline_rounded, size: 18, color: AppColors.error),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (index < _items.length - 1) const Divider(height: 1, indent: 18, endIndent: 18),
      ],
    );
  }

  Widget _buildTotalsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Column(
        children: [
          _totalRow('Subtotal', '₹${_subtotal.toStringAsFixed(0)}'),
          const SizedBox(height: 10),
          _totalRow('GST (18%)', '₹${_gst.toStringAsFixed(0)}'),
          const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Grand Total', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
              Text('₹${_total.toStringAsFixed(0)}', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _totalRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
        Text(value, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x10000000), blurRadius: 12, offset: Offset(0, -3))],
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 52,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text('Cancel', style: GoogleFonts.inter(color: AppColors.textSecondary, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            flex: 2,
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _selectedCustomer != null
                            ? 'Invoice saved for $_selectedCustomer!'
                            : 'Invoice saved as Walk-in!',
                      ),
                      backgroundColor: AppColors.success,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check_rounded, color: Colors.white, size: 20),
                label: Text('Save Invoice', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Customer Picker Sheet ──────────────────────────────────────────────────────
class _CustomerPickerSheet extends StatefulWidget {
  final List<String> customers;
  final String? selected;
  final void Function(String) onSelect;
  final VoidCallback onClear;

  const _CustomerPickerSheet({
    required this.customers,
    required this.selected,
    required this.onSelect,
    required this.onClear,
  });

  @override
  State<_CustomerPickerSheet> createState() => _CustomerPickerSheetState();
}

class _CustomerPickerSheetState extends State<_CustomerPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.customers
        .where((c) => c.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Customer', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                if (widget.selected != null)
                  GestureDetector(
                    onTap: () { widget.onClear(); Navigator.pop(context); },
                    child: Text('Clear', style: GoogleFonts.inter(color: AppColors.error, fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              autofocus: true,
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Search customer...',
                prefixIcon: const Icon(Icons.search_rounded, size: 20, color: AppColors.textMuted),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Walk-in option
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.person_outline_rounded, color: AppColors.textMuted, size: 20),
            ),
            title: Text('Walk-in Customer', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
            subtitle: Text('No customer assigned', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMuted)),
            trailing: widget.selected == null
                ? const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20)
                : null,
            onTap: () { widget.onClear(); Navigator.pop(context); },
          ),
          const Divider(indent: 20, endIndent: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final customer = filtered[i];
                final isSelected = widget.selected == customer;
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.infoLight,
                    child: Text(
                      customer[0],
                      style: GoogleFonts.inter(color: AppColors.primary, fontWeight: FontWeight.w700),
                    ),
                  ),
                  title: Text(customer, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20)
                      : null,
                  onTap: () { widget.onSelect(customer); Navigator.pop(context); },
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Add Item Sheet ─────────────────────────────────────────────────────────────
class _AddItemSheet extends StatefulWidget {
  final void Function(_InvoiceItem) onAdd;
  const _AddItemSheet({required this.onAdd});

  @override
  State<_AddItemSheet> createState() => _AddItemSheetState();
}

class _AddItemSheetState extends State<_AddItemSheet> {
  final _nameCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        left: 20, right: 20, top: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 16),
          Text('Add Item', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
          const SizedBox(height: 20),
          _label('Item Name'),
          const SizedBox(height: 6),
          TextField(controller: _nameCtrl, decoration: const InputDecoration(hintText: 'e.g. Rice 5kg')),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('Unit Price (₹)'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _priceCtrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(hintText: '0'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Qty'),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() { if (_qty > 1) _qty--; }),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.remove_rounded, size: 18, color: AppColors.textSecondary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text('$_qty', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _qty++),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.add_rounded, size: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: ElevatedButton(
                onPressed: () {
                  final name = _nameCtrl.text.trim();
                  final price = double.tryParse(_priceCtrl.text) ?? 0;
                  if (name.isNotEmpty && price > 0) {
                    widget.onAdd(_InvoiceItem(name: name, price: price, qty: _qty));
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text('Add to Invoice', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
        text,
        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textMuted),
      );
}

// ── Data Model ─────────────────────────────────────────────────────────────────
class _InvoiceItem {
  String name;
  double price;
  int qty;
  _InvoiceItem({required this.name, required this.price, required this.qty});
}
