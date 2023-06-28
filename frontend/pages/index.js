import {useState, useEffect} from "react";
import PrimaryButton from "../components/primary-button";


export default function Home() {
    const [ethereum ,setEthereum] = useState(undefined);
    const [connectedAccount, setConnectedAccount] = useState(undefined);

    const handleAccounts = (accounts) => {
        if(accounts.length > 0) {
          const account = accounts[0];
          console.log('we have an authorized account', account);
          setConnectedAccount(account);
        } else {
            console.log("No authorized accounts yet");
        }
    }

    const getConnectedAccount = async () => {
        if(window.ethereum) {
          setEthereum(window.ethereum);
        }
        if (ethereum) {
            const accounts = await ethereum.request({method: 'eth_accounts'});
            handleAccounts(accounts);
        }
    }

    useEffect(()=> getConnectedAccount(),[]);

    const connectAccount = () => { };
    if(!ethereum){
      return <p>Please install MetaMask to connect to this site</p>;
    }

    if(!connectedAccount){
      return <PrimaryButton onClick={connectAccount}>Connect MetaMask Wallet</PrimaryButton>;
    }

    return <p>connected Account: {connectedAccount}</p>


} 