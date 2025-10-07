{
    'name': 'POS Custom Receipt',
    'version': '1.0.0',
    'category': 'Point of Sale',
    'summary': 'Customize POS receipt header',
    'depends': ['point_of_sale'],
    'assets': {
        'point_of_sale._assets_pos': [
            'pos_receipt_module/static/src/xml/pos_receipt.xml',
        ],
    },
    'installable': True,
    'application': False,
    'auto_install': False,
}
