# Electroneum Real-Time Voting System  

A **decentralized real-time voting application** based on the **Electroneum blockchain**, leveraging its **5-second block finality** and **low transaction fees**. Users vote for the "**Best Meme Coin of 2025**" using ETN, and those who support the winning option receive rewards.  

---

## 📌 Project Overview  

### 🔹 Name & Slogan  
- **Name**: MemeVote  
- **Slogan**: "Vote with ETN, Win with Fun!"  

### 🔹 Description  
MemeVote is a **web-based dApp** that allows users to vote for the **Best Meme Coin of 2025** (e.g., Dogecoin, Shiba Inu, Pepe Coin, ETN) using **Electroneum (ETN)**.  

It showcases **Electroneum’s 5-second finality** and **low-fee microtransactions**, providing a seamless voting experience.  
- 🚀 **Fast**: 5-second confirmation times  
- 💰 **Cheap**: Near-zero transaction fees  
- 🎮 **Engaging**: Gamified voting experience  

### 🎯 Target Users  
- **Crypto enthusiasts** looking for a fun, low-cost way to engage in meme coin voting  
- **Meme coin communities** that want a decentralized and transparent voting system  
- **ETN supporters** who want to showcase the blockchain’s fast finality and microtransaction capabilities  

---

## ⚡ Features  

### ✅ Core Functionalities  
1. **Voting Interface**  
   - Displays 4 meme coin options with **real-time vote updates**.  
   - Users connect **MetaMask** and **pay 1 ETN per vote**.  
   - 24-hour voting period with a **live countdown timer**.  

2. **Real-Time Updates**  
   - Vote counts refresh **every 5 seconds**, demonstrating **ETN’s block finality**.  
   - **Simple UI** visualizing voting progress.  

3. **Results Display**  
   - After voting ends, the **winning meme coin** and **reward distribution** are displayed.  

4. **User Authentication**  
   - Appwrite provides **sign-up/login** (optional **anonymous mode**).  
   - **Voting history** stored off-chain.  

### 🚀 Problems Solved  
| Problem | Solution |
|---------|----------|
| **Slow Confirmation**: Traditional blockchain voting is delayed. | **ETN’s 5-sec finality** ensures real-time updates. |
| **High Fees**: Micro-voting is expensive on many chains. | **1 ETN per vote**, leveraging ETN’s low fees. |
| **Low Engagement**: No incentives to vote. | **Gamified voting** with rewards for the winning side. |

---

## 🏆 Voting Rules  

- **Fee**: **1 ETN per vote** (testnet amount, adjustable).  
- **Duration**: **24 hours** per voting round.  
- **Eligibility**: Users with **testnet ETN** and **MetaMask** can vote (**no limit per user**).  
- **Winner**: Meme coin with the **most votes at the end** wins.  

### 💰 Funds Flow  
| Step | Action |
|------|--------|
| **User votes** | Sends **1 ETN** to the **smart contract**. |
| **Reward Pool** | All votes accumulate into the **reward pool** (e.g., 100 votes = 100 ETN). |
| **Distribution** | **95% of the pool** is shared among users who voted for the winning meme coin. |
| **Example** | **100 ETN pool**, Dogecoin wins (**60 votes**). 95 ETN is split, each voter gets **~1.58 ETN**. |

---

## 🔗 Integration with Electroneum  

- **⚡ 5-Second Finality**: Real-time vote updates using blockchain event listeners.  
- **💰 Low Fees**: Affordable **1 ETN voting cost**.  
- **🔗 EVM Compatibility**: Built with **Solidity + MetaMask**, leveraging ETN’s **Ethereum-like** infrastructure.  

---

## 🛠️ Tech Stack  

- **Frontend**: [Next.js](https://nextjs.org/) (**React framework** with SSR).  
- **Blockchain**: **Solidity** smart contract, deployed on **Electroneum testnet**.  
- **Backend**: [Appwrite](https://appwrite.io/) for **user authentication** and **off-chain data storage**.  
- **Web3**: [Web3.js](https://web3js.readthedocs.io/) for **MetaMask integration** and **contract interaction**.  

---

## 📜 License  
This project is licensed under the **MIT License**.  

---





