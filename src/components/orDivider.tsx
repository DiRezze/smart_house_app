import { StyleSheet, Text, View } from 'react-native'
import React from 'react'
import { colors } from '../constants/colors'

const OrDivider = () => {
  return (
    <View style={styles.container}>
      <View style={styles.child}></View>
      <Text style={styles.text}>Ou</Text>
      <View style={styles.child}></View>
    </View>
  )
}

export default OrDivider

const styles = StyleSheet.create({
    container: {
        width: '85%',
        display: 'flex',
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-around'
    },
    child: {
        height: 1,
        borderBlockColor: colors.ui_gray,
        borderBottomWidth: 1,
        width: '40%'
    },
    text: {
        textAlign: 'center',
    }
});
