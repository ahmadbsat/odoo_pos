{
    'name': 'POS Custom Receipt',
    'version': '18.0.1.0.0',
    'category': 'Point of Sale',
    'summary': 'Customize POS receipt header',
    'description': """
        Custom POS Receipt
        ==================
        * Custom header with company name
        * Larger order numbers
        * Custom styling
    """,
    'author': 'Your Name',
    'depends': ['point_of_sale'],
    'assets': {
        'point_of_sale._assets_pos': [
            'pos_receipt_module/static/src/xml/pos_receipt.xml',
            'pos_receipt_module/static/src/css/pos_receipt.css',
        ],
    },
    'installable': True,
    'application': False,
    'auto_install': False,
    'license': 'LGPL-3',
}
