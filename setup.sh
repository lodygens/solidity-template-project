 nvm use 18
 yarn init -2
 yarn config set nodeLinker node-modules
 yarn add dotenv
 yarn add hardhat --dev
 rm -f README.md
 yarn hardhat init
 yarn add mocha --dev
 yarn add @openzeppelin/contracts
 mv test tests
cat > .mocharc.json <<EOF
{
  "require": "hardhat/register",
  "timeout": 40000,
  "_": ["tests/**/*.ts"]
}
EOF
cat > hardhat.config.ts << EOF 
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  paths: { tests: "tests" }
};
export default config;
EOF
cat > tsconfig.json << EOF 
{
  "include": ["./scripts", "./tests", "./typechain-types"],
  "files": ["./hardhat.config.ts"],
  "compilerOptions": {
    "target": "es2020",
    "module": "commonjs",
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "strict": true,
    "skipLibCheck": true
  },
}
EOF

if [ ! -f ".env" ]; then
	cat > .env << EOF 
MNEMONIC="here is where your twelve words mnemonic should be put my friend"
PRIVATE_KEY="<your private key here if you don't have a mnemonic seed>"
INFURA_API_KEY="********************************"
INFURA_API_SECRET="********************************"
ALCHEMY_API_KEY="********************************"
ETHERSCAN_API_KEY="********************************"
EOF
	echo "Please fill .env file"
fi

yarn hardhat compile
yarn hardhat test



cat > scripts/deployment.ts << EOF

async function main() {

}

/**
 * let call main()
 */
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});

EOF

echo "to run scripts : yarn run ts-node --files" 
