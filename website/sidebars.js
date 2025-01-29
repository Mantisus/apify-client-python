module.exports = {
    sidebar: [
        {
            type: 'category',
            label: 'Overview',
            collapsed: false,
            items: [
                {
                    type: 'autogenerated',
                    dirName: '01_overview',
                },
            ],
        },
        {
            type: 'category',
            label: 'Concepts',
            collapsed: false,
            items: [
                {
                    type: 'autogenerated',
                    dirName: '02_concepts',
                },
            ],
        },
        {
            type: 'category',
            label: 'Examples',
            collapsed: false,
            items: [
                {
                    type: 'autogenerated',
                    dirName: '03_examples',
                },
            ],
        },
        // {
        //     type: 'category',
        //     label: 'Upgrading',
        //     collapsed: false,
        //     items: [
        //         {
        //             type: 'autogenerated',
        //             dirName: '04_upgrading',
        //         },
        //     ],
        // },
        {
            type: 'doc',
            id: 'changelog',
        },
    ],
};
