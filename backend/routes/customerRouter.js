const express = require('express');

const { addCustomer, getAllCustomers, getCustomerById, updateCustomer, deleteCustomer } = require ('../controller/customerController');

const router = express.Router();

router.post('/add', addCustomer);
router.get('/get-all', getAllCustomers);
router.get('/get-by-id/:id', getCustomerById);
router.put('/update/:id',updateCustomer);
router.delete('/delete/:id', deleteCustomer);

module.exports = router;