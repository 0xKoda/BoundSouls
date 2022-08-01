# Bound Souls - SBT 

A simple solution for soul bound tokens as discussed in this [paper](https://vitalik.ca/general/2022/01/26/soulbound.html).


## Details

Registry.sol provides a public API for querying the state of souls.

Souls may bind after 2 nominations from fellow soulbound.

Souls may be revoked by upstanding soulBound, the Arbiters.


### Setup

```sh
git clone https://github.com/0xKoda/BoundSouls.git
cd BoundSouls
```

### Run Tests

```sh
forge test
```
