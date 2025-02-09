const { exec } = require('child_process');

async function monitorICP() {
  const txnHash = await getLatestTxnHashFromICP();
  const isVerified = await verifyCalimeroTransaction(txnHash);

  if (isVerified) {
    console.log('Transaction verified. Unlocking tokens on ICP...');
    exec(`dfx canister call bridge_icp unlockTokens '(principal "user-principal-id", 100)'`);
  }
}
