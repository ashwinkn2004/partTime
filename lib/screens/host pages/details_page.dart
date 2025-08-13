import 'package:flutter/material.dart';

class PostJobRequestPage extends StatefulWidget {
  const PostJobRequestPage({Key? key}) : super(key: key);

  @override
  State<PostJobRequestPage> createState() => _PostJobRequestPageState();
}

class _PostJobRequestPageState extends State<PostJobRequestPage> {
  final _formKey = GlobalKey<FormState>();

  // controllers
  final addressCtrl = TextEditingController();
  final hourlyRateCtrl = TextEditingController();
  final wardrobeNotesCtrl = TextEditingController();
  final additionalInfoCtrl = TextEditingController();

  // dropdown values
  String? jobCategory;
  String? staffNeeded;
  String? genderPref;
  String? languageReq;
  String? wardrobeType;

  // options (replace with your real lists)
  final jobCategories = ['Waiter', 'Security', 'Cleaner', 'Photographer'];
  final staffOptions = ['1', '2', '3', '4', '5+'];
  final genderOptions = ['Male', 'Female', 'Any'];
  final languageOptions = ['English', 'Hindi', 'Any'];
  final wardrobeTypes = ['Formal', 'Casual', 'Uniform Provided'];

  // date/time
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  // colors (tuned to your screenshot)
  final bg = const Color(0xFFFFFFFF);
  final fieldFill = const Color(0xFFF3F3F5); // light grey fill
  final textPrimary = const Color(0xFF1F1F1F);
  final textSecondary = const Color(0xFF8B8B8F);
  final divider = const Color(0xFFE9E9EC);
  final cta = const Color(0xFFE7B669); // warm amber for CTA

  InputDecoration _filled(String label, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: textSecondary),
      filled: true,
      fillColor: fieldFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      suffixIcon: suffix == null
          ? null
          : Padding(padding: const EdgeInsets.only(right: 8), child: suffix),
    );
  }

  Widget _chevrons() => Column(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Icon(Icons.expand_less, size: 18),
      Icon(Icons.expand_more, size: 18),
    ],
  );

  Widget _sectionTitle(String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Text(
      text,
      style: TextStyle(
        color: textPrimary,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    ),
  );

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final base = isStart ? (startDate ?? now) : (endDate ?? startDate ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: base,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 3),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
          // if start > end, clear end
          if (endDate != null && endDate!.isBefore(startDate!)) {
            endDate = null;
          }
        } else {
          endDate = picked;
        }
      });
    }
  }

  Future<void> _pickTime({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  String _fmtDate(DateTime? d) => d == null
      ? ''
      : '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  String _fmtTime(TimeOfDay? t) => t == null ? '' : t.format(context);

  // cross-field validation at submit
  String? _crossValidate() {
    // ensure end date >= start date if both picked
    if (startDate != null && endDate != null) {
      if (endDate!.isBefore(startDate!)) {
        return 'End date cannot be before start date.';
      }
      // same-day time ordering
      if (startTime != null &&
          endTime != null &&
          _isSameDay(startDate!, endDate!)) {
        final s = DateTime(0, 1, 1, startTime!.hour, startTime!.minute);
        final e = DateTime(0, 1, 1, endTime!.hour, endTime!.minute);
        if (e.isBefore(s) || e.isAtSameMomentAs(s)) {
          return 'End time must be after start time.';
        }
      }
    }
    // hourly rate positive number
    if (hourlyRateCtrl.text.trim().isEmpty) return 'Please enter hourly rate.';
    final rate = double.tryParse(hourlyRateCtrl.text.trim());
    if (rate == null || rate <= 0)
      return 'Hourly rate must be a positive number.';
    return null;
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  void _submit() {
    final fieldErrors = _crossValidate();
    final ok = _formKey.currentState?.validate() ?? false;
    if (ok && fieldErrors == null) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form looks good. Proceeding...')),
      );
      // TODO: call your API or navigate to payment
    } else {
      // show first cross-field error if any
      if (fieldErrors != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(fieldErrors)));
      }
    }
  }

  @override
  void dispose() {
    addressCtrl.dispose();
    hourlyRateCtrl.dispose();
    wardrobeNotesCtrl.dispose();
    additionalInfoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bg,
        foregroundColor: textPrimary,
        centerTitle: true,
        title: Text(
          'Post a Job Request',
          style: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: 2,
        textSecondary: textSecondary,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              _sectionTitle('Job Details'),

              // job category
              DropdownButtonFormField<String>(
                value: jobCategory,
                items: jobCategories
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => jobCategory = v),
                validator: (v) =>
                    v == null ? 'Please select Job Category' : null,
                decoration: _filled('Select Job Category', suffix: _chevrons()),
              ),
              const SizedBox(height: 14),

              // staff needed
              DropdownButtonFormField<String>(
                value: staffNeeded,
                items: staffOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => staffNeeded = v),
                validator: (v) =>
                    v == null ? 'Please select number of staff' : null,
                decoration: _filled(
                  'Select Number of Staff Needed',
                  suffix: _chevrons(),
                ),
              ),
              const SizedBox(height: 14),

              // gender pref
              DropdownButtonFormField<String>(
                value: genderPref,
                items: genderOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => genderPref = v),
                validator: (v) =>
                    v == null ? 'Please select gender preference' : null,
                decoration: _filled(
                  'Select Gender Preference',
                  suffix: _chevrons(),
                ),
              ),
              const SizedBox(height: 14),

              // language
              DropdownButtonFormField<String>(
                value: languageReq,
                items: languageOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => languageReq = v),
                validator: (v) => v == null ? 'Please select language' : null,
                decoration: _filled(
                  'Select Language Requirement',
                  suffix: _chevrons(),
                ),
              ),
              const SizedBox(height: 14),

              // start date
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: _fmtDate(startDate)),
                onTap: () => _pickDate(isStart: true),
                validator: (_) =>
                    startDate == null ? 'Select start date' : null,
                decoration: _filled('Select Start Date', suffix: _chevrons()),
              ),
              const SizedBox(height: 14),

              // end date
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: _fmtDate(endDate)),
                onTap: () => _pickDate(isStart: false),
                validator: (_) => endDate == null ? 'Select end date' : null,
                decoration: _filled('Select End Date', suffix: _chevrons()),
              ),
              const SizedBox(height: 14),

              // start time
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: _fmtTime(startTime)),
                onTap: () => _pickTime(isStart: true),
                validator: (_) =>
                    startTime == null ? 'Select start time' : null,
                decoration: _filled('Select Start Time', suffix: _chevrons()),
              ),
              const SizedBox(height: 14),

              // end time
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: _fmtTime(endTime)),
                onTap: () => _pickTime(isStart: false),
                validator: (_) => endTime == null ? 'Select end time' : null,
                decoration: _filled('Select End Time', suffix: _chevrons()),
              ),

              _sectionTitle('Location & Payment'),

              TextFormField(
                controller: addressCtrl,
                decoration: _filled('Enter  Event Address'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Enter event address'
                    : null,
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: hourlyRateCtrl,
                decoration: _filled('Enter  Hourly Rate'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Enter hourly rate';
                  final x = double.tryParse(v.trim());
                  if (x == null || x <= 0) return 'Hourly rate must be > 0';
                  return null;
                },
              ),

              _sectionTitle('Wardrobe Requirements'),

              DropdownButtonFormField<String>(
                value: wardrobeType,
                items: wardrobeTypes
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => wardrobeType = v),
                decoration: _filled(
                  'Select  Wardrobe  Type',
                  suffix: _chevrons(),
                ),
                validator: (v) =>
                    v == null ? 'Please select wardrobe type' : null,
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: wardrobeNotesCtrl,
                maxLines: 4,
                decoration: _filled('Additional Wardrobe Requirements'),
              ),

              _sectionTitle('Additional Info'),
              TextFormField(
                controller: additionalInfoCtrl,
                maxLines: 5,
                decoration: _filled(''),
              ),

              const SizedBox(height: 20),

              // CTA button
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cta,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Proceed to Advanced Payment',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final Color textSecondary;
  const _BottomNav({required this.currentIndex, required this.textSecondary});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black87,
      unselectedItemColor: textSecondary,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          label: 'Requests',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_available_outlined),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
      onTap: (_) {},
    );
  }
}
