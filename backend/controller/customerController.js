const Customer = require('../model/customer');

// Add customer
const addCustomer = async (req, res) => {
    const { customerName, locationData } = req.body;

    try {
        const newCustomer = new Customer({ customerName, locationData });
        await newCustomer.save();
        res.status(201).json(newCustomer);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

//get all customer
const getAllCustomers = async (req, res) => {
    try {
        const customers = await Customer.find();
        res.status(200).json(customers);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// get one customer
const getCustomerById = async (req, res) => {
    const { id } = req.params;

    try {
        const customer = await Customer.findById(id);
        if (!customer) {
            return res.status(404).json({ message: 'Customer not found' });
        }
        res.status(200).json(customer);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// Update a customer by ID
const updateCustomer = async (req, res) => {
    const { id } = req.params;
    const { customerName, locationData } = req.body;

    try {
        const customer = await Customer.findById(id);
        if (!customer) {
            return res.status(404).json({ message: 'Customer not found' });
        }

        customer.customerName = customerName;
        customer.locationData = locationData;
        await customer.save();

        res.status(200).json(customer);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

// Delete a customer by ID
const deleteCustomer = async (req, res) => {
    const { id } = req.params;

    try {
        const customer = await Customer.findById(id);
        if (!customer) {
            return res.status(404).json({ message: 'Customer not found' });
        }

        await Customer.deleteOne({ _id: id });
        res.status(200).json({ message: 'Customer deleted successfully' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};


module.exports = { addCustomer, getAllCustomers, getCustomerById, updateCustomer, deleteCustomer };