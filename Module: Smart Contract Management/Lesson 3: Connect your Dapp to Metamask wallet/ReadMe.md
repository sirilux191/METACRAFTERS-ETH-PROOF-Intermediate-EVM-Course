# Metamask Wallet Connection with ethers.js

This script demonstrates how to connect to a Metamask wallet using ethers.js. It provides the following features:

## Features

- Connects to the Ethereum network through Metamask.
- Prompts the user to connect their Metamask wallet.
- Retrieves the user's Ethereum address.
- Retrieves the user's ETH balance.
- Uses the ethers.js library for seamless integration with Metamask.
- Provides a simple and straightforward implementation.

## Functions

The script includes the following function:

### connectMetamask()

This function connects to the Ethereum network through Metamask. It prompts the user to connect their Metamask wallet, creates a Web3Provider instance, retrieves the signer (current user), and fetches the user's Ethereum address and ETH balance.

## Getting Started

To use this script, follow these steps:

1. Ensure you have Metamask installed and set up in your browser.

2. Install the required dependencies by running the following command:

   ```shell
   npm install ethers
   ```

3. Copy the contents of the script.js file into your own JavaScript file or integrate it into your existing codebase.

```javascript
// Import the ethers.js library
const ethers = require("ethers");

// Connect to the Ethereum network using Metamask
async function connectMetamask() {
  // Prompt the user to connect their Metamask wallet
  await window.ethereum.enable();

  // Create a new instance of the Web3Provider using Metamask
  const provider = new ethers.providers.Web3Provider(window.ethereum);

  // Get the signer (current user) from the provider
  const signer = provider.getSigner();

  // Retrieve the user's Ethereum address
  const address = await signer.getAddress();

  console.log("Connected to Metamask");
  console.log("Wallet Address:", address);

  // Now you can use the signer to interact with the blockchain
  // For example, you can send transactions, read contract data, etc.
  // Here's an example of getting the user's ETH balance
  const balance = await signer.getBalance();
  console.log("ETH Balance:", ethers.utils.formatEther(balance));
}

// Call the connectMetamask function to connect
connectMetamask();
```

4. In your HTML file, include a reference to your JavaScript file:

   ```html
   <script src="path/to/your/script.js"></script>
   ```

5. Open your webpage and check the browser console to view the connection status, wallet address, and ETH balance.

## Authors

Metacrafter Sirilux
[@AadityaChandankar](https://twitter.com/aadityachandan1)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
