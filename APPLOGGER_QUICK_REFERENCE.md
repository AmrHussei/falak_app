# 📖 AppLogger - Quick Reference

## 📍 Location
```
lib/core/utils/app_logger.dart
```

## 🎯 Quick Usage

### Basic Logging
```dart
AppLogger.info('Information message');
AppLogger.success('Operation successful');
AppLogger.warning('Potential issue');
AppLogger.error('Error occurred', error: e, stackTrace: stackTrace);
AppLogger.debug('Debug information');
```

### Specialized Logging
```dart
AppLogger.network('GET /api/users - 200 OK');
AppLogger.auth('User authenticated');
AppLogger.splash('Splash screen loading...');
AppLogger.socket('Socket connected');
AppLogger.notification('Notification received');
```

### Formatting
```dart
AppLogger.section('SECTION TITLE');  // Section header with dividers
AppLogger.divider();                 // Separator line
AppLogger.object('Label', object);   // Log complex objects
AppLogger.json('Label', jsonData);   // Log JSON data
```

## 🎨 Icons Reference

| Icon | Method | Purpose |
|------|--------|---------|
| 📘 | `info()` | General information |
| 🔍 | `debug()` | Debug info (dev only) |
| ⚠️ | `warning()` | Warnings |
| ❌ | `error()` | Errors |
| ✅ | `success()` | Success messages |
| 🌐 | `network()` | Network activity |
| 🔐 | `auth()` | Authentication |
| 🚀 | `splash()` | Splash screen |
| 🔌 | `socket()` | Socket events |
| 🔔 | `notification()` | Notifications |

## 🔧 Configuration

```dart
// Enable/disable logging
AppLogger.setEnabled(true);   // Enable
AppLogger.setEnabled(false);  // Disable
```

## 💡 Pro Tips

1. **Use specific loggers** - `AppLogger.network()` instead of `AppLogger.info()`
2. **Include stack traces** - Always pass `stackTrace` to `error()`
3. **Use sections** - Group related logs with `section()`
4. **Debug vs Info** - Use `debug()` for verbose dev info, `info()` for general info
5. **Production** - Disable with `setEnabled(false)` in release builds

## 📊 Example Output

```
────────────────────────────────────────
📘 INFO INITIALIZATION
────────────────────────────────────────
12:34:56.789 📘 INFO Starting service...
12:34:56.850 ✅ SUCCESS Service started
12:34:56.851 🚀 SPLASH Loading splash...
12:34:57.010 🔐 AUTH Authenticating...
12:34:57.150 ✅ SUCCESS Authentication successful
────────────────────────────────────────
```

## ✅ Migration Checklist

Replace these:
- ❌ `print()` → ✅ `AppLogger.info()`
- ❌ `debugPrint()` → ✅ `AppLogger.debug()`
- ❌ `print('Error: $e')` → ✅ `AppLogger.error('Message', error: e)`

---

**Keep this handy for quick reference!** 📚

