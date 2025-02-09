
import { RpcClient } from '@calimero-network/calimero-client';

const rpcClient = new RpcClient({
  nodeUrl: process.env.CALIMERO_API_URL,
});

const verifyCalimeroTransaction = async (txnHash) => {
  const response = await rpcClient.execute({
    applicationId: process.env.CALIMERO_APP_ID,
    method: 'verify_transaction',
    argsJson: { txnHash },
  });

  if (response.isValid) {
    console.log('Transaction is valid');
    return true;
  } else {
    console.log('Invalid transaction');
    return false;
  }
};
