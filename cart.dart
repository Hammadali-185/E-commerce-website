// Retrieve cart data from localStorage
let cart = JSON.parse(localStorage.getItem('cart')) || [];

// Elements for displaying cart items and total amount
const cartItemsTable = document.getElementById('cartItems');
const totalAmountElement = document.getElementById('totalAmount');

// Function to render cart items
function renderCart() {
    cartItemsTable.innerHTML = ''; // Clear existing items

    let totalAmount = 0;

    cart.forEach((item, index) => {
        const row = document.createElement('tr');

        // Product Image
        const itemImageCell = document.createElement('td');
        const itemImage = document.createElement('img');
        itemImage.src = item.image; // Use image URL from item object
        itemImage.alt = item.name;
        itemImageCell.appendChild(itemImage);
        row.appendChild(itemImageCell);

        // Item name
        const itemNameCell = document.createElement('td');
        itemNameCell.textContent = item.name;
        row.appendChild(itemNameCell);

        // Item price
        const itemPriceCell = document.createElement('td');
        itemPriceCell.textContent = `$${item.price.toFixed(2)}`;
        row.appendChild(itemPriceCell);

        // Item quantity with + and - buttons
        const itemQuantityCell = document.createElement('td');
        const decrementButton = document.createElement('button');
        decrementButton.textContent = '-';
        decrementButton.classList.add('quantity-button');
        decrementButton.addEventListener('click', () => updateQuantity(index, -1)); // Decrease quantity

        const quantitySpan = document.createElement('span');
        quantitySpan.textContent = item.quantity;
        quantitySpan.classList.add('quantity-display');

        const incrementButton = document.createElement('button');
        incrementButton.textContent = '+';
        incrementButton.classList.add('quantity-button');
        incrementButton.addEventListener('click', () => updateQuantity(index, 1)); // Increase quantity

        itemQuantityCell.appendChild(decrementButton);
        itemQuantityCell.appendChild(quantitySpan);
        itemQuantityCell.appendChild(incrementButton);
        row.appendChild(itemQuantityCell);

        // Item total (price * quantity)
        const itemTotalCell = document.createElement('td');
        const itemTotal = item.price * item.quantity;
        itemTotalCell.textContent = `$${itemTotal.toFixed(2)}`;
        row.appendChild(itemTotalCell);

        // Remove button
        const removeButtonCell = document.createElement('td');
        const removeButton = document.createElement('button');
        removeButton.textContent = 'Remove';
        removeButton.classList.add('remove-button');
        removeButton.addEventListener('click', () => removeItemFromCart(index));
        removeButtonCell.appendChild(removeButton);
        row.appendChild(removeButtonCell);

        // Add row to table
        cartItemsTable.appendChild(row);

        // Update total amount
        totalAmount += itemTotal;
    });

    // Update total amount in the DOM
    totalAmountElement.textContent = totalAmount.toFixed(2);
}

// Function to update quantity
function updateQuantity(index, change) {
    cart[index].quantity += change;
    if (cart[index].quantity < 1) {
        cart[index].quantity = 1; // Prevent quantity from being less than 1
    }
    localStorage.setItem('cart', JSON.stringify(cart)); // Update localStorage
    renderCart(); // Re-render the cart
}

// Function to remove item from cart
function removeItemFromCart(index) {
    cart.splice(index, 1); // Remove item from cart array
    localStorage.setItem('cart', JSON.stringify(cart)); // Update localStorage
    renderCart(); // Re-render the cart
}

// Add item to cart (to avoid duplicates)
function addToCart(item) {
    // Check if the item already exists in the cart
    const existingItem = cart.find(cartItem => cartItem.id === item.id);
    
    if (existingItem) {
        existingItem.quantity += 1; // If it exists, just increase quantity
    } else {
        cart.push(item); // Otherwise, add a new item to the cart
    }

    localStorage.setItem('cart', JSON.stringify(cart)); // Save to localStorage
    renderCart(); // Re-render the cart

    // Show a success message once, not twice
    if (!existingItem) {
        alert(`${item.name} has been added to your cart.`);
    }
}

// Render the cart when the page loads
renderCart();

// Optional: Add functionality to clear the cart after checkout
document.getElementById('checkoutButton').addEventListener('click', () => {
    localStorage.removeItem('cart'); // Clear cart data
    cart = [];
    renderCart(); // Update the cart display
});
