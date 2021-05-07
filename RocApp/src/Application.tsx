import 'react-native-gesture-handler';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { Button, StyleSheet, Text, View } from 'react-native';

const RocStack = createStackNavigator();

export function ResultsScreen({ navigation }): JSX.Element {
  return (
    <View style={styles.container}>
      <Text>Results Screen</Text>
      <Button title="Back to search" onPress={() => navigation.navigate('Search')} />
      <StatusBar style="auto" />
    </View>
  );
}

export function SearchScreen({ navigation }): JSX.Element {
  return (
    <View style={styles.container}>
      <Text>Search Screen</Text>
      <Button title="Search" onPress={() => navigation.navigate('Results')} />
      <StatusBar style="auto" />
    </View>
  );
}

export default function App(): JSX.Element {
  return (
    <NavigationContainer>
      <RocStack.Navigator>
        <RocStack.Screen name="Search" component={SearchScreen} options={{ title: 'Search' }} />
        <RocStack.Screen name="Results" component={ResultsScreen} options={{ title: 'Results' }} />
      </RocStack.Navigator>
    </NavigationContainer>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
