# Yotpo test app
## Requirements
```bash
The store owners implement the integration with Yotpo by inserting a javascript to their website.
End users write reviews using Yotpo javascript which makes an API call from the end user browser to Yotpo\'s server.
Yotpo wants to develop a new feature: Single sign on.
Given an end user which is already logged in to the store, we want to provide an ability to generate a review with the following fields:

1. user email - the reviewer email
2. user type - verified buyer / verified reviewer
3. product_id - the product on which the review is written
4. review content
5. review score
The first 3 fields need to be verified by the store owner and must not be able to be tampered.
Please build a server which provides the capability to generate content while ensuring no one tampers with the first 3 fields or fakes them. An example of tampering is for a malicious user to create a review and identify himself as a verified buyer on a product he didn’t buy

Notes:
1. The requests may arrive from web browser of the reviewers (our store owner’s users).
2. Our server can’t make requests to the store server for validation of fields

You may write the server itself at any language / framework you choose for.
However, other than the HTTP server itself, you are not allowed to use any frameworks / libraries to develop your solution.
The endpoint should return the following:

on success: {"status": 200}
on failure: {"status": 401}
```

## Solution
To ensure than requests comes from trusted source, both sides are implementing SSL encryption.
Yotpo generates public and private keys. Public is available for stores.

Each store generates public and private keys. Public key is accessible for Yotpo.

**Store:**
 - Inserts js script on product page.
 - Creates json {"user_email": "XX", "user_type": "XX", "product_id": "XX"}, encrypt it (see details in [lib/EncryptoSigno.encrypt()](https://github.com/olkeene/yotpo_test_app/blob/master/lib/encrypto_signo.rb) ) and assigns to js variable.
 - Generate signature from same json using own private key and assign to js variable.

Yotpo js script sends the next data:
 - crypted_body
 - signature
 - review content
 - review score

**On backend**

1. Decrypt crypted_body
1. Verify than request comes from trusted store by checking signature using store's public key
2. Merge decrypted_body which contains 3 fields and with 2 review data fields
3. Save review and profit!

**Check [spec/controllers/reviews_spec](https://github.com/olkeene/yotpo_test_app/blob/master/spec/controllers/reviews_spec.rb) for more cases**

## Todos

## How to run
  Run `docker-compose up`

## Run specs
  `docker-compose run app bundle exec rspec`
