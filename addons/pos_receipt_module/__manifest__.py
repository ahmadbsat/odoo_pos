{
    'name': 'POS Receipt Header Font Customization',
    'version': '1.0.0',
    'category': 'Point of Sale',
    'summary': 'Customize POS receipt header font size',
    'description': """
        This module inherits the point_of_sale.OrderReceipt component
        to make the header font bigger for better visibility.
    """,
    'author': 'Your Company',
    'website': 'https://www.yourcompany.com',
    'depends': ['point_of_sale'],
    'data': [],
    'assets': {
        'point_of_sale.assets': [
            'odoo_receipt_module/static/src/xml/pos_receipt.xml',
        ],
    },
    'installable': True,
    'auto_install': False,
    'application': False,
}
