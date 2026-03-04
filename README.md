# flutter_assignment

## Voucher Purchase

This implementation follows a BLoC-driven reactive flow where data and logic are separated from the UI. The process begins by parsing the mock JSON into a model and emitting an initial state. When the user inputs an amount or selects a payment method, the Bloc updates the state, triggering the UI to recalculate discountAmount, youPay, and savings in real-time. The UI remains synchronized with the API's constraints, automatically disabling the "Pay" button if disablePurchase is true or if the entered amount violates the minAmount and maxAmount limits.

