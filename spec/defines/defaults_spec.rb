# frozen_string_literal: true

require 'spec_helper'

describe 'haproxy::defaults' do
  let :pre_condition do
    'class{"haproxy":
        config_file => "/tmp/haproxy.cfg"
     }
    '
  end
  let(:title) { 'test' }
  let(:facts) do
    {
      networking: {
        ip: '1.1.1.1'
      },
      os: {
        family: 'RedHat'
      },
      concat_basedir: '/dne'
    }
  end

  context 'with a single option' do
    let(:params) do
      {
        options: { 'balance' => 'roundrobin' }
      }
    end

    it {
      is_expected.to contain_concat__fragment('haproxy-test_defaults_block').with(
        'order' => '25-test',
        'target' => '/tmp/haproxy.cfg',
        'content' => "\n\ndefaults test\n  balance roundrobin\n",
      )
    }
  end
end
