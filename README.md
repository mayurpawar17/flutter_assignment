# flutter_assignment

## Voucher Purchase

This app follows a clean Repo–Bloc–State–UI flow where data and business logic are separated from the interface. First, the Repository fetches the mock or API JSON data and converts it into a VoucherModel. The Bloc then requests this data from the repository, stores it in the state, and manages all business logic such as handling user input, calculating discounts, final price, and savings, and validating rules like minAmount, maxAmount, and disablePurchase. Whenever the user enters an amount or selects a payment method, the Bloc updates the state, which automatically triggers the UI to rebuild through BlocBuilder. The screen simply reads values from the state and displays them, keeping everything in sync. Based on the state, the “Pay” button is enabled or disabled, ensuring that the UI always follows the API rules without handling logic directly.
