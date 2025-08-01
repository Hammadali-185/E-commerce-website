
// Load cart items
function loadCart() {
    const cart = JSON.parse(localStorage.getItem('cart')) || [];
    const cartItemsContainer = document.getElementById('cartItems');
    cartItemsContainer.innerHTML = '';

    cart.forEach(item => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td><img src="${item.image}" alt="${item.name}" style="width: 50px;"></td>
            <td>${item.name}</td>
            <td>$${item.price}</td>
            <td>
                <button onclick="updateQuantity(${item.id}, -1)">-</button>
                ${item.quantity}
                <button onclick="updateQuantity(${item.id}, 1)">+</button>
            </td>
            <td>$${(item.price * item.quantity).toFixed(2)}</td>
            <td><button onclick="removeFromCart(${item.id})">Remove</button></td>
        `;
        cartItemsContainer.appendChild(row);
    });

    updateTotalAmount(cart);
}

// Remove item from cart
function removeFromCart(itemId) {
    let cart = JSON.parse(localStorage.getItem('cart')) || [];
    cart = cart.filter(item => item.id !== itemId);
    localStorage.setItem('cart', JSON.stringify(cart));
    loadCart();
}

// Update quantity
function updateQuantity(itemId, change) {
    let cart = JSON.parse(localStorage.getItem('cart')) || [];
    let item = cart.find(cartItem => cartItem.id === itemId);

    if (item) {
        item.quantity += change;
        if (item.quantity <= 0) removeFromCart(itemId);
        else localStorage.setItem('cart', JSON.stringify(cart));
    }
    loadCart();
}

// Update total amount
function updateTotalAmount(cart) {
    const totalAmount = cart.reduce((total, item) => total + item.price * item.quantity, 0);
    document.getElementById('totalAmount').textContent = totalAmount.toFixed(2);
}

// Initialize cart on page load
document.addEventListener('DOMContentLoaded', loadCart);
const row = document.createElement('tr');
row.innerHTML = `
    <td><img src="${item.image}" alt="${item.name}" style="width: 50px;"></td>
    <td class="cart-font">${item.name}</td>
    <td class="cart-font">$${item.price}</td>
    <td class="cart-font">
        <button onclick="updateQuantity(${item.id}, -1)">-</button>
        ${item.quantity}
        <button onclick="updateQuantity(${item.id}, 1)">+</button>
    </td>
    <td class="cart-font">$${(item.price * item.quantity).toFixed(2)}</td>
    <td><button onclick="removeFromCart(${item.id})">Remove</button></td>
`;