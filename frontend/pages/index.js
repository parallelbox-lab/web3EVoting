import {useState, useEffect} from "react";
import PrimaryButton from "../components/primary-button";
import abi from "../utils/Voting.json";
import { Input } from "postcss";
import { ethers } from "ethers";

export default function Home() {
    const [ethereum ,setEthereum] = useState(undefined);
    const [connectedAccount, setConnectedAccount] = useState(undefined);
    const[votersName, addVotersName] = useState("");
    const[candidateParty, setCandidateParty] = useState("");
    const connectedAddress = "0x7052066dffe6281011fb555d5f71ea11a5a13065";
    const contractAbi = abi.abi;

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

    useEffect(() => getConnectedAccount(),[]);

    const connectAccount = async () => { 
      if(!ethereum){
        alert("MetaMask is required to connect an account");
        return ;
      }
      const accounts = await ethereum.request({method : 'eth_requestAccounts'});
      handleAccounts(accounts);
    };
   

    if(!connectedAccount){
      return <PrimaryButton onClick={connectAccount}>Connect MetaMask Wallet</PrimaryButton>;
    }

    const addVoters = async (e)=> {
      e.preventDefault();
      if (!ethereum) {
        console.error('Ethereum object is required to create a keyboard');
        return;
      }
      const provider = new ethers.provider.Web3Provider(ethereum);
      const signer = provider.getSigner();
      const votingContract = new ethers.Contract(connectedAddress, contractAbi, signer);
      const createTxn = await votingContract.addCandidates(votersName, candidateParty); 
      


    }

    return (<div>
      <p>connected Account: {connectedAccount}</p>
      <form>
      <label>Add Candidate's name</label>
      <input type="text" name="add-voters-name" value={votersName} onChange={(e)=> {addVotersName(e.target.value)}}/>
      <br/>
      <label>Add Candidate's party</label>
      <input type="text" name="add-candidate-party" value={candidateParty} onChange={(e)=> {setCandidateParty(e.target.value)}}/>
      <PrimaryButton type="submit" onClick={addVoters}>Add name</PrimaryButton>
      </form>
      </div>

)} 