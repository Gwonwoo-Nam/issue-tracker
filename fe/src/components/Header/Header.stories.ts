import type { Meta, StoryObj } from '@storybook/react';
import Header from './Header';

const meta = {
  title: 'Example/Header',
  component: Header,
} satisfies Meta<typeof Header>;

export default meta;
type Story = StoryObj<typeof meta>;

export const Default: Story = {
  args: {
    url: 'https://images.unsplash.com/photo-1600354587397-681c16c184bf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80',
  },
};
