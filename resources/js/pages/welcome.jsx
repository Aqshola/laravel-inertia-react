import { Head } from "@inertiajs/react";
import { Flex, Typography } from "antd";
import React from "react";

export default function Welcome() {
    const STYLING={
        flexContainerStyle:{
            width:"100%",
            minHeight:'100vh',
        },
        headingStyle:{
            textAlign:'center'
        }
    }
    return (
        <>
        <Head>
            <title>Welcome Page Inertia React</title>
        </Head>
        <Flex style={STYLING.flexContainerStyle} justify="center" align="center" vertical>
            <Typography.Title level={5} style={STYLING.headingStyle}>Welcome to Larvel Inertia React</Typography.Title>
        </Flex>
        </>
    );
}
