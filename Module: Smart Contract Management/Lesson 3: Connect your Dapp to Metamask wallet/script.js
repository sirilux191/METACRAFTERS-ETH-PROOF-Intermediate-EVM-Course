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
