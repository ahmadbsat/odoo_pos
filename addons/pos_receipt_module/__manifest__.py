{
    'name': 'POS Receipt Font Size',
    'version': '1.0.0',
    'category': 'Point of Sale',
    'summary': 'Increase font size in POS receipts',
    'description': """
        This module increases the font size in Point of Sale receipts
        for better readability.
    """,
    'author': 'Your Name',
    'website': 'https://www.yourwebsite.com',
    'depends': ['point_of_sale'],
    'data': [],
    'assets': {
        'point_of_sale._assets_pos': [
            'pos_receipt_font_size/static/src/css/pos_receipt.css',
        ],
    },
    'installable': True,
    'application': False,
    'auto_install': False,
    'license': 'LGPL-3',
}
