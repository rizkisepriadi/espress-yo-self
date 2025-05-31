import 'package:espress_yo_self/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'qr_scanner_overlay_shape.dart';
import 'qr_permission_handler.dart';

class QrScreen extends ConsumerStatefulWidget {
  const QrScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QrScreenState();
}

class _QrScreenState extends ConsumerState<QrScreen> with QrPermissionHandler {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanning = true;

  @override
  void initState() {
    super.initState();
    checkCameraPermission();
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image selected: ${image.name}'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No image selected'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (!hasPermission) {
      return _buildPermissionDenied(colorScheme, textTheme);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            minimumSize: WidgetStateProperty.all(Size(55.w, 55.h)),
            padding: WidgetStateProperty.all(EdgeInsets.all(12.w)),
            iconSize: WidgetStateProperty.all(24.sp),
            shape: WidgetStateProperty.all(const CircleBorder()),
          ),
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: _onDetect,
            overlayBuilder: (context, constraints) {
              return Container(
                decoration: ShapeDecoration(
                  shape: QrScannerOverlayShape(
                    borderColor: colorScheme.primary,
                    borderRadius: 16.r,
                    borderLength: 40.w,
                    borderWidth: 4.w,
                    cutOutSize: 250.w,
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 80.h,
            right: 10.w,
            child: Column(
              children: [
                _buildActionButton(
                  icon: Icons.flash_on,
                  onTap: () => cameraController.toggleTorch(),
                ),
                SizedBox(height: 16.h),
                _buildActionButton(
                  icon: Icons.photo_library,
                  onTap: _pickImageFromGallery,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 200.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(120),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  SizedBox(height: 8.h),
                  Text(
                    "Scan QR Code",
                    style: textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Align QR code within the frame to scan",
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      {required IconData icon, required VoidCallback onTap}) {
    return Container(
      width: 56.w,
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28.r),
          child: Icon(
            icon,
            color: Colors.black,
            size: 28.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionDenied(ColorScheme colorScheme, TextTheme textTheme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 80.sp,
              color: colorScheme.primary,
            ),
            SizedBox(height: 24.h),
            Text(
              "Camera Permission Denied",
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              "To scan QR codes, please allow camera access in your device settings.",
              style:
                  textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: checkCameraPermission,
              child: const Text("Grant Permission"),
            ),
          ],
        ),
      ),
    );
  }

  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
      _handleQRResult(barcodes.first.rawValue!);
    }
  }

  Future<void> _handleQRResult(String qrData) async {
    if (!isScanning) return;

    setState(() {
      isScanning = false;
    });
    cameraController.stop();

    try {
      final userState = ref.read(getUserViewModelProvider);
      final userId = userState.asData?.value.id;

      if (userId == null) {
        _showErrorDialog("User not logged in");
        return;
      }

      _showLoadingDialog();

      await ref
          .read(transactionsViewModelProvider.notifier)
          .addTransactionFromQR(
            userId: userId,
            qrData: qrData,
          );

      if (mounted) Navigator.of(context).pop();

      _showSuccessDialog(qrData);
    } catch (e) {
      if (mounted) Navigator.of(context).pop();

      _showErrorDialog("Failed to process QR: ${e.toString()}");
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            SizedBox(width: 16.w),
            const Text("Processing QR..."),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(String qrData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Success!"),
        content: Text("QR Code processed successfully!\n\nData: $qrData"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resumeScanning();
            },
            child: const Text("Scan Another"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // context.go('/history');
            },
            child: const Text("View History"),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _resumeScanning();
            },
            child: const Text("Try Again"),
          ),
        ],
      ),
    );
  }

  void _resumeScanning() {
    cameraController.start();
    setState(() {
      isScanning = true;
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
